#ifndef BEST_FIRST_SEARCH_H
#define BEST_FIRST_SEARCH_H

#include "logger.h"
#include "graph.h" 
#include "path.h"
#include "beam_search.h"

//You may need additional includes here

namespace vss {

	/*!Performs an informed BestFirstSearch on a given version space graph.
		\note The BestFirstSearch algorithm uses a fringe of paths, which are sorted according to the
			heuristic evaluation of their last node. At each iteration of the search algorithm,
			the best path is chosen for expansion.

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
	PathWithCost bestFirstSearch(Graph<Data> const& g, std::string const& from, std::string const& to,
								 double (*heuristicsFn)(Graph<Data> const& g, std::string const& v))
	{
    return beamSearch(g, from, to, heuristicsFn, -1);
	}

}

#endif //BEST_FIRST_SEARCH_H
