#include "graph.h"

//Uncomment the line bellow to see logging in A*
//#define LOGGING

#include "depth_first_search.h"
#include "a_star_search.h"

#include "breadth_first_search.h"
#include "best_first_search.h"
#include "beam_search.h"

#include <iostream>

using namespace std;
using namespace vss;

typedef Graph<int> IntGraph;

template <class Data>
double heuristics(Graph<Data> const& g, std::string const& v)
{
	Data value = Data();
	g.getData(v, value);
	return static_cast<double>(value);
}

template <class Data>
void addNonDirected(Graph<Data>& g, const string& from, const string& to, double cost)
{
	g.addEdge(from,to,cost);
	g.addEdge(to,from,cost);
}

int main()
{
	Graph<int> g;
	g.addVertix("Arad", 366);
	g.addVertix("Bucharest", 0);
	g.addVertix("Craiova", 160);
	g.addVertix("Dobreta", 242);
	g.addVertix("Eforie", 161);
	g.addVertix("Fagaras", 176);
	g.addVertix("Giurgiu", 77);
	g.addVertix("Hirsova", 151);
	g.addVertix("Iasi", 226);
	g.addVertix("Lugoj", 244);
	g.addVertix("Mehadia", 241);
	g.addVertix("Neamt", 234);
	g.addVertix("Oradea", 380);
	g.addVertix("Pitesti", 10);
	g.addVertix("Rimnicu Vilcea", 193);
	g.addVertix("Sibiu", 253);
	g.addVertix("Timisoara", 329);
	g.addVertix("Urziceni", 80);
	g.addVertix("Vaslui", 199);
	g.addVertix("Zerind", 374);

	addNonDirected(g, "Arad", "Zerind", 75);
	addNonDirected(g, "Arad", "Sibiu", 140);
	addNonDirected(g, "Arad", "Timisoara", 118);
	addNonDirected(g, "Zerind", "Oradea", 71);
	addNonDirected(g, "Oradea", "Sibiu", 151);
	addNonDirected(g, "Timisoara", "Lugoj", 111);
	addNonDirected(g, "Lugoj", "Mehadia", 70);
	addNonDirected(g, "Mehadia", "Dobreta", 75);
	addNonDirected(g, "Dobreta", "Craiova", 120);
	addNonDirected(g, "Sibiu", "Fagaras", 99);
	addNonDirected(g, "Sibiu", "Rimnicu Vilcea", 80);
	addNonDirected(g, "Fagaras", "Bucharest", 211);
	addNonDirected(g, "Rimnicu Vilcea", "Craiova", 148);
	addNonDirected(g, "Craiova", "Pitesti", 138);
	addNonDirected(g, "Pitesti", "Bucharest", 101);
	addNonDirected(g, "Giurgiu", "Bucharest", 90);
	addNonDirected(g, "Neamt", "Iasi", 87);
	addNonDirected(g, "Iasi", "Vaslui", 92);
	addNonDirected(g, "Vaslui", "Urziceni", 142);
	addNonDirected(g, "Urziceni", "Bucharest", 85);
	addNonDirected(g, "Eforie", "Hirsova", 86);
	addNonDirected(g, "Hirsova", "Urziceni", 98);
	
	g.printout(cout) << endl;

	cout << "BreadthFS: " << breadthFirstSearch(g, "Arad", "Bucharest") << endl;
	cout << "DepthFS: " << depthFirstSearch(g, "Arad", "Bucharest") << endl;
	cout << "BestFS: " << bestFirstSearch(g, "Arad", "Bucharest", &heuristics<int>) << endl;
	cout << "BeamSearch(2): " << beamSearch(g, "Arad", "Bucharest", &heuristics<int>, 2) << endl;
	cout << "BeamSearch(4): " << beamSearch(g, "Arad", "Bucharest", &heuristics<int>, 4) << endl;
	cout << "A*: " << aStarSearch(g, "Arad", "Bucharest", &heuristics<int>) << endl;
	return 0;
}

