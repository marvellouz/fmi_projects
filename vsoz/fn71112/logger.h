#ifndef LOGGER_H
#define LOGGER_H

#include <iostream>

template <class Container>
std::ostream& log(Container const& container)
{
	for (typename Container::const_iterator it = container.begin();
		 it != container.end();
		 it++)
	{
		std::clog << ' ' << *it;
	}
	return std::clog;
}

#ifdef LOGGING
#	define LOG_CONTAINER(containerName, msg) \
		std::clog << msg << std::endl; \
		log(containerName) << std::endl
#	define LOG_MSG(msg) \
		std::clog << msg << endl
#else
#	define LOG_CONTAINER(containerName, msg)
#	define LOG_MSG(msg)
#endif

#endif 
