#ifndef DEPTH_FIRST_SEARCH_H
#define DEPTH_FIRST_SEARCH_H

#include "graph.h" 
#include "path.h"

#include <set> 
#include <stack>

namespace vss {

	/*!Performs an uninformed DepthFirstSearch on a given version space graph.
		\note DepthFirstSearch algorithm uses a stack for a fringe.

		\tparam Data The type of data held in the version space graph, i.e. the data representing
			a state of the version space.

		\param g Graph on which the serarch will be performed.
		\param from Identity of the vertix from which a path is searched.
		\param to Identity of the vertix to which a path is searched.
		
		\return Empty path if none of the two vertices is in the graph or there is no path begining 
			in 'from' and ending in 'to', otherwise the first path found by the algorithm is returned.
	*/
	template <class Data>
	Path depthFirstSearch(Graph<Data>& g, std::string const& from, std::string const& to)
	{
		Path result;
		if(g.hasVertix(from) && g.hasVertix(to))
		{
			std::set<std::string> visited;
			std::stack<Path> fringe;
			Path initial;
			initial.push_back(from);
			fringe.push(initial);

			while(!fringe.empty())
			{
				Path current = fringe.top();
				fringe.pop();
				
				if (current.back() == to)
				{
					result = current;
					break;
				} else {
					visited.insert(current.back());

					typename Graph<Data>::SuccessorList successors = g.getSuccessors(current.back());
					for (typename Graph<Data>::SuccessorList::const_iterator successor = successors.begin();
						 successor != successors.end();
						 ++successor)
					{
                                                std::string const& succ_name = successor->second;
						if (visited.find(succ_name) == visited.end() &&
                                                  std::find(current.begin(), current.end(), succ_name) == current.end())
						{
							Path extendedPath(current);
							extendedPath.push_back(successor->second);
							fringe.push(extendedPath);
						}
					}
				}
			}
		}
		return result;
	}
}

#endif // DEPTH_FIRST_SEARCH_H
