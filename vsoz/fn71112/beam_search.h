#ifndef BEAM_SEARCH_H
#define BEAM_SEARCH_H

#include "logger.h"
#include "graph.h" 
#include "path.h"
#include <deque>


//You may need additional includes here

namespace vss {

	/*!Performs an informed BeamSearch on a given version space graph.
		\note The BeamSearch is a variation of the BestFirstSearch algorithm, which supports a 
			fringe of limited size, i.e. after sorting the fringe according to the heuristic
			evaluation of the paths, it trims the fringe to the max number of supported paths.

		\tparam Data The type of data held in the version space graph, i.e. the data representing
			a state of the version space.

		\param g Graph on which the serarch will be performed.
		\param from Identity of the vertix from which a path is searched.
		\param to Identity of the vertix to which a path is searched.
		\param heuristicsFn Pointer to function that gives the heuristic evaluation of a 
			given vertix in the given graph.
		\param beamSize Size of the beam (max size of the used fringe)

		\return Empty path if none of the two vertices is in the graph or there is no path begining 
			in 'from' and ending in 'to', otherwise the first path found by the algorithm is returned,
			along with its cost (in this case the heuristic evaluation of the path's last vertix).
	*/

  bool comparePaths(PathWithCost i, PathWithCost j) { return i.first < j.first;}

	template <class Data>
	PathWithCost beamSearch(Graph<Data> const& g, std::string const& from, std::string const& to,
								 double (*heuristicsFn)(Graph<Data> const& g, std::string const& v),
								 unsigned int beamSize)
	{
		PathWithCost result;
    std::deque<PathWithCost> fringe;
    if (!g.hasVertix(from) || !g.hasVertix(to)) return result;
    fringe.push_back(std::make_pair(heuristicsFn(g, from), Path(1, from)));
    while(!fringe.empty()){
      std::sort(fringe.begin(), fringe.end(), comparePaths);
      
      if (fringe.size() > beamSize) fringe.resize(beamSize);

      PathWithCost& curr_front = fringe.front();
      Path& path = curr_front.second;
      if (curr_front.second.back() == to) return curr_front;
      

      typename Graph<Data>::SuccessorList successors = g.getSuccessors(curr_front.second.back());
      for (typename Graph<Data>::SuccessorList::const_iterator successor = successors.begin();
          successor != successors.end();
          ++successor){
        if (std::find(path.begin(), path.end(), successor->second) == path.end()){
          PathWithCost newPath(curr_front);
          newPath.second.push_back(successor->second);
          newPath.first = heuristicsFn(g, successor->second);
          fringe.push_back(newPath);
        }
      }
      
      fringe.pop_front();
    }


		return result;
	}

}

#endif //BEAM_SEARCH_H
