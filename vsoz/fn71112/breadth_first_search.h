#ifndef BREADTH_FIRST_SEARCH_H
#define BREADTH_FIRST_SEARCH_H

#include "logger.h"
#include "graph.h" 
#include "path.h"
#include <deque>

//You may need additional includes here

namespace vss {

  /*!Performs an uninformed BreadthFirstSearch on a given version space graph.
    \note BreadthFirstSearch algorithm uses a queue for a fringe, in this way performing a
    layered deepening.

    \tparam Data The type of data held in the version space graph, i.e. the data representing
    a state of the version space.

    \param g Graph on which the serarch will be performed.
    \param from Identity of the vertix from which a path is searched.
    \param to Identity of the vertix to which a path is searched.

    \return Empty path if none of the two vertices is in the graph or there is no path begining 
    in 'from' and ending in 'to', otherwise the first path found by the algorithm is returned.
   */
  template <class Data>
    Path breadthFirstSearch(Graph<Data>& g, std::string const& from, std::string const& to)
    {
      Path result;

      std::deque<Path> fringe;
      if (!g.hasVertix(from) || !g.hasVertix(to)) return result;
      fringe.push_back(Path(1, from));
      while(!fringe.empty()){

        Path& curr_front = fringe.front();
        if (curr_front.back() == to) return curr_front;


        typename Graph<Data>::SuccessorList successors = g.getSuccessors(curr_front.back());
        for (typename Graph<Data>::SuccessorList::const_iterator successor = successors.begin();
            successor != successors.end();
            ++successor){
          if (std::find(curr_front.begin(), curr_front.end(), successor->second) == curr_front.end()){
            Path newPath(curr_front);
            newPath.push_back(successor->second);
            fringe.push_back(newPath);
          }
        }

        fringe.pop_front();
      }



      return result;
    }
}

#endif //BREADTH_FIRST_SEARCH_H
