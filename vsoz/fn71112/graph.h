#ifndef GRAPH_H
#define GRAPH_H

/*!
	\file
	\breif Definition of generic graph.
*/

#include <map>
#include <set>
#include <string>
#include <vector>
#include <iostream>

#include <cassert>

namespace vss {

	/*!This class represents a generic graph implementation.
		\tparam Type of data stored in each vertix.
	*/
	template <typename Data>
	class Graph
	{
	public:

		typedef std::pair<double, std::string> Successor;
		typedef std::vector<Successor> SuccessorList;

		Graph();
		~Graph();

		std::ostream& printout(std::ostream& out) const;
                SuccessorList getSuccessors(std::string const& vertixName) const;
		bool empty() const;

		bool addVertix(std::string const& vertixName, Data const& data);
		bool hasVertix(std::string const& vertixName) const;
		bool getData(std::string const& vertixName, Data& outData) const;

		bool addEdge(std::string const& from, std::string const& to, double value = 1.0);
		bool hasEdge(std::string const& from, std::string const& to) const;
		
		std::set<std::string> vertices() const;

	private:
		struct Vertix {
			Data data;
			SuccessorList* successors;
		};

		typedef std::map<std::string, Vertix> ContentsMap;
		ContentsMap contents;

		//to ensure that the graph is noncopyable
		Graph(Graph const&);
		Graph& operator=(Graph const&);
	};

	template <typename Data>
	inline Graph<Data>::Graph()
		:contents()
	{}
	
	template <typename Data>
	inline Graph<Data>::~Graph()
	{
		for(typename ContentsMap::iterator it = contents.begin(); it!=contents.end(); ++it)
		{
			delete it->second.successors;
		}
	}

        template <typename Data>
          inline typename Graph<Data>::SuccessorList Graph<Data>::getSuccessors(std::string const& vertixName) const
          {
            SuccessorList result;
            typename ContentsMap::const_iterator found = contents.find(vertixName);
            if (found != contents.end())
              result = *(found->second.successors);
            return result;
          }
	
	template <typename Data>
	inline bool Graph<Data>::empty() const
	{
		return contents.empty();
	}


	template <typename Data>
	inline bool Graph<Data>::addVertix(std::string const& vertixName, Data const& data)
	{
		bool result = true;
		if (contents.find(vertixName) != contents.end()) {
			result = false;
		} else {
			Vertix newVertix;
                        newVertix.data = data;
                        newVertix.successors = new SuccessorList();
			contents[vertixName] = newVertix;
		}

		return result;
	}
	
	template <typename Data>
	inline bool Graph<Data>::hasVertix(std::string const& vertixName) const
	{
		return contents.find(vertixName) != contents.end();
	}
		
	template <typename Data>
	inline bool Graph<Data>::getData(std::string const& vertixName, Data& outData) const
	{
		bool result = true;

		typename ContentsMap::const_iterator found = contents.find(vertixName);
		if (found == contents.end()) {
			result = false;
		} else {
			outData = found->second.data;
		}

		return result;
	}

	template <typename Data>
	inline bool Graph<Data>::addEdge(std::string const& from, std::string const& to, double value)
	{
		if (!hasVertix(from) || !hasVertix(to))
			return false;
		
		typename ContentsMap::iterator found = contents.find(from);
		assert(found != contents.end());

		found->second.successors->push_back(Successor(value,to));

		return true;
	}
	
	template <typename Data>
	inline bool Graph<Data>::hasEdge(std::string const& from, std::string const& to) const
	{
		return hasVertix(from) && hasVertix(to);
	}

	template <typename Data>
	inline std::set<std::string> Graph<Data>::vertices() const
	{
		std::set<std::string> result;
		
		for (typename ContentsMap::iterator it = contents.begin;
			 it != contents.end();
			 ++it)
		{
			result.insert(it->first);
		}
		
		return result;
	}

	template <typename Data>
	std::ostream& Graph<Data>::printout(std::ostream& out) const
	{
		out << "Vertices: ";
		for (typename ContentsMap::const_iterator it = contents.begin();
			 it != contents.end();
			 ++it)
		{
			out << " v(" << it->first << ',' << it->second.data << ")  ";
		}

		out << std::endl << "Arcs: ";
		for (typename ContentsMap::const_iterator it = contents.begin();
			 it != contents.end();
			 ++it)
		{
			for (typename SuccessorList::const_iterator nextNodeIt = it->second.successors->begin();
				 nextNodeIt != it->second.successors->end();
				 ++nextNodeIt)
			{
				out << " arc(" << it->first << ',' << nextNodeIt->second << ',' << nextNodeIt->first << ")  ";
			}
		}
		out << std::endl;

		return out;
	}


} //namespace vss

#endif
