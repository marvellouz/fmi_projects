#ifndef PATH_H
#define PATH_H

#include <list>
#include <string>
#include <algorithm>
#include <utility>

namespace vss {

	//Used members of class list
	//void push_back(data);
	//data& back();
	//void pop_back();
	//
	//void push_front(data);
	//data& front();
	//void pop_front();
	typedef std::list<std::string> Path;
	
	//first -> double -> path cost
	//second -> path -> the path itself
	typedef std::pair<double, Path> PathWithCost;


	//performs a < comparison for two PathWithCost
	// REMEMBER: typedef std::pair<double, Path> PathWithCost;
	bool lessThanPath(PathWithCost const& lhs, PathWithCost const& rhs)
	{
		//left hand side's cost is less than right hand side's cost
		return lhs.first < rhs.first

			//or if the costs are equal, left hand side's path is shorter than right hand side path
			|| (lhs.first == rhs.first && lhs.second.size() < rhs.second.size());
	}


	//this is an ouput operator. you can just use it.
	inline std::ostream& operator<< (std::ostream& out, Path const& path)
	{
		if (path.empty())
		{
			out << "P();" << std::endl;
		} else {
			out << "P(";

			for (Path::const_iterator it = path.begin();
				 it != path.end();
				 ++it)
			{
				out << *it << "-> ";
			}

			out << "\b\b\b) " << std::endl;
		}
		return out;
	}

	inline std::ostream& operator<< (std::ostream& out, PathWithCost const& pathCost)
	{
		out << "Cost[" << pathCost.first << "], " << pathCost.second;
		return out;
	}

}

#endif //PATH_H
