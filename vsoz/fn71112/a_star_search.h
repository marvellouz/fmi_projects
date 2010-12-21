#ifndef A_STAR_SEARCH_H
#define A_STAR_SEARCH_H

#include "logger.h"
#include "graph.h" 
#include "path.h"

#include <algorithm> //for std::sort
#include <deque> 
#include <set> 
#include <stack>

namespace vss {

	/*!Performs an informed A* Search on a given version space graph.
		\note The A* Search algorithm is a uniform cost algorithm, which uses a fringe of paths
			sorted according to the	sum of the heuristic evaluation of their last node and the
			overall cost of the path (the sum of weights of edges in the path). At each iteration 
			of the search algorithm, the best path is chosen for expansion.

		\tparam Data The type of data held in the version space graph, i.e. the data representing
			a state of the version space.

		\param g Graph on which the serarch will be performed.
		\param from Identity of the vertix from which a path is searched.
		\param to Identity of the vertix to which a path is searched.
		\param heuristicsFn Pointer to function that gives the heuristic evaluation of a 
			given vertix in the given graph.
		
		\return Empty path if none of the two vertices is in the graph or there is no path begining 
			in 'from' and ending in 'to', otherwise the first path found by the algorithm is returned,
			along with its cost (in this case the heuristic evaluation of the path's last vertix).
	*/
	template <class Data>
	PathWithCost aStarSearch(Graph<Data> const& g, std::string const& from, std::string const& to,
							 double (*heuristicsFn)(Graph<Data> const& g, std::string const& v))
	{
		LOG_MSG("+=+=+=+=+=+=+=+=+=+=+=+=+=+=+= BEGIN A* Search from '" << from << "' to '" << to << "'");
		//Initialize empty result
		PathWithCost result;

		//Perform the search only if both vertices belong to the graph
		if(g.hasVertix(from) && g.hasVertix(to))
		{
			//Use set to mark visited vertices. std::set can contain given value only once.
			std::set<std::string> visited;

			//Use deque for the fringe.
			//std::deque allows for putting/taking value from both ends,
			//	but it is used here because it's values can be sorted by using std::sort
			//The fringe will contain paths with their costs. This is used for the sorting.
			std::deque<PathWithCost> fringe;

			//Create initial path, containing only the starting vertix.
			Path initialPath;
			initialPath.push_back(from);

			//Add this path to the fringe along with its heuristic evaluation.
			fringe.push_back(PathWithCost(heuristicsFn(g,from), initialPath));

			//The search algorithm will work while there are values in the fringe.
			while(!fringe.empty())
			{
				//These macros will log a message only if the #define LOGGING is used before this header is included.
				//You can use this to see if your implementation works properly.
				LOG_MSG("===========Begin iteration");
				LOG_CONTAINER(fringe, "log front before sorting");
				
				//Use std::sort to sort the fringe according to the paths' cost.
				// see implementation of lessThanPath in path.h
				std::sort(fringe.begin(), fringe.end(), lessThanPath);
				LOG_CONTAINER(fringe, "log front after sorting");

				//Once the paths are sorted, the best path is at the front of the fringe.
				PathWithCost current = fringe.front();
				fringe.pop_front(); //remove front path from the fringe

				//Add last vertix of the chosen path to the set of visited vertices.
				//current is a PathWithCost, which is an std::pair<double, Path>
				//current.second is a Path, which is an std::list<std::string>
				//current.second.back() is the last element of the std::list, i.e. the last vertix of the path
				visited.insert(current.second.back());
				LOG_MSG("Chosen vertix: " << current.second.back());

				//If the last vertix of the chosen path is the endpoint of our search, then we have found a path.
				if (current.second.back() == to)
				{
					result = current;
					break;
				} else {
					//Otherwise we need to get all successors of that last vertix to expand the current path with them.
					//Graph<Data>::SuccessorList is a template dependent type, i.e. it depends on the template
					//argument 'Data'. Therefore we have to add typename before it.
					//It is also a type defined within the Graph type so we use Graph<Data>::.
					//It is a typedef for std::vector<Successor const> and Successor is a typedef
					//for std::pair<double, std::string>, meaning pair of (cost_of_edge_to_successor, successor_name)
					typename Graph<Data>::SuccessorList successors = g.getSuccessors(current.second.back());

					//We will use a const_iterator of the std::vector (here typedefed as a Graph<Data>::SuccessorList)
					//to iterate over all of the found successors.
					//When using iterators with std:: containers, we start with .begin() and increase the iterator
					//with the ++ operator, until we reach .end() The .end() will return an interator that points to
					//a position after the last element in the container.
					//We will name the iterator variable successor. It can be used as a pointer to a value in the
					//container. I.e. it will point to a Graph<Data>::Successor, which is an std::pair<double, std::string>.
					//To use the cost, we will call successor->first, to use the vertix name, successor->second.
					for (typename Graph<Data>::SuccessorList::const_iterator successor = successors.begin();
						 successor != successors.end();
						 ++successor)
					{
						//If the name of the vertix is NOT found in the set of visited vertices, i.e. if the 
						//	iterator returned by the find method of std::set returns the .end() iterator
						if (visited.find(successor->second) == visited.end() &&

							//and if the name of the vertix is NOT found in the current path, i.e. if the
							//std::find called for the current path, returns the current path's .end() iterator
							std::find(current.second.begin(), current.second.end(), 
									  successor->second) == current.second.end())

						//then we know that the successor is a new vertix and we can safely expand the path with it.
						{
							//We create a new path, by copying the current path.
							//current is a PathWithCost, which is std::pair<double, Path>
							//current.second is Path
							Path expandedPath(current.second);

							//And we add the new successor vertix to the expandedPath.
							//expandedPath is a Path, which is std::list
							//std::list::push_back() method adds element to the back of the list.
							//successor->second returns the name of the successor.
							expandedPath.push_back(successor->second);

							//Before adding the extended path to the fringe we need to calculate it's cost.
							//The cost of the current path before the expansion is in current.first.
							//It contains the sum of the edges and the heuristic evaluation of the last node.
							//so before adding the cost of the edge to the successor and the heuristic evaluation
							//of the successor we need to subtract the heuristic evaluation of the last node.
							double expandedCost = current.first - heuristicsFn(g,current.second.back()) 
								+ successor->first + heuristicsFn(g,successor->second);

							//Finally we just add the expanded path and its cost to the end of the fringe.
							//This will make the finge unsorted, but we will sort it in the beginning of 
							//the next iteration.
							fringe.push_back(PathWithCost(expandedCost, expandedPath));

							LOG_MSG("Expanded path with " << successor->second 
									<< ". New path is: " << fringe.back());
						}
					}
				}
				LOG_MSG("===========END iteration");
			}
		}
		LOG_MSG("+=+=+=+=+=+=+=+=+=+=+=+=+=+=+= END A* Search +=+=+=+=+=+=+=+=+=+=+=+=+=+=+=");
		return result;
	}
}

#endif // A_STAR_SEARCH_H
