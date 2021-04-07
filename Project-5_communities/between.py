import sys
import re
import matplotlib.pyplot as plot
import networkx as nx


G = nx.Graph()
positions = {} # a position map of the nodes (cities)

#terminal input for creating the graph from txt 
txtFile = sys.stdin
for ln in txtFile:
    xl = [v.strip() for v in ln.split(',')]
    nde = xl[0] + ',' + xl[1]
    # print(nde)

    lnr = int(xl[4])
    G.add_node(nde, pos=(float(xl[2]), float(xl[3])))

    # add the connections(edges) between the nodes of the graph
    while lnr > 0:
        nl = next(txtFile)
        lnr -= 1
        connection = [v.strip() for v in nl.split(',')]
        nodeX = connection[0] + ',' + connection[1]
        G.add_edge(nde, nodeX, weight=int(connection[2]))

cnt = 0
delEdge = []
while (nx.is_connected(G)):
    bwtns= sorted(nx.edge_betweenness_centrality(G).items(), key=lambda v:-v[1])
    z = bwtns[0][0][0]
    b = bwtns[0][0][1]

    delEdge.append([z, b, G[z][b]['weight']])
    cnt+=1
# print("Deleted edges: " + str(cnt))

cnt2 = 0
for edg in delEdge:
    z = edg[0]
    b = edg[1]
    q = edg[2]
    G.add_edge(z, b, weight=q)
    cnt2 += 1
    if (nx.is_connected(G)):
        G.remove_edge(z,b)
        cnt2 -= 1
# print("Readded edges: " + str(cnt2))

positions = nx.get_node_attributes(G, 'pos')

# plot the city graph
plot.figure(figsize=(8,8))
nx.draw(G,
        positions,
        node_size   = [4 for v in G],
        with_labels = False)

plot.savefig('city-plot.png')
plot.show()