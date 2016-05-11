//CSC 573-001 - HW4 Q1

FromDump(click_ex1.dump, STOP true)
-> r :: Classifier(12/0806, 12/0800, -)
r[0] -> ArpCount :: Counter -> c :: Classifier(20/0001, 20/0002, -)
r[1] -> IpCount :: Counter -> d :: Classifier(23/01, 23/06, 23/11, -)
r[2] -> Discard

c[0] -> ArpReqCount :: Counter -> Discard
c[1] -> ArpRepCount :: Counter -> Discard
c[2] -> Discard

d[0] -> IcmpCount :: Counter -> Discard
d[1] -> TcpCount :: Counter -> e :: Classifier(36/0050, 36/0016, -)
d[2] -> UdpCount :: Counter -> ToDump(click_ex1_udp.dump, ENCAP IP) -> f :: Classifier(36/0035, -)
d[3] -> Discard

e[0] -> HttpDestCount :: Counter -> Discard
e[1] -> sshDestCount :: Counter -> Discard
e[2] -> Discard

f[0] -> UdpDnsCount :: Counter -> Discard
f[1] -> Discard
 
DriverManager(pause,
set ArpCountVar $(ArpCount.count), print > click_ex1_counters.dump "# of ARP packets: " $ArpCountVar,
set ArpReqCountVar $(ArpReqCount.count), print >> click_ex1_counters.dump "# of ARP request packets: " $ArpReqCountVar,
set ArpRepCountVar $(ArpRepCount.count), print >> click_ex1_counters.dump "# of ARP reply packets: " $ArpRepCountVar,
set IpCountVar $(IpCount.count), print >> click_ex1_counters.dump "# of IP packets: " $IpCountVar,
set IcmpCountVar $(IcmpCount.count), print >> click_ex1_counters.dump "# of ICMP packets: " $IcmpCountVar,
set TcpCountVar $(TcpCount.count), print >> click_ex1_counters.dump "# of TCP packets: " $TcpCountVar,
set HttpDestCountVar $(HttpDestCount.count), print >> click_ex1_counters.dump "# of TCP-HTTP packets: " $HttpDestCountVar,
set sshDestCountVar $(sshDestCount.count), print >> click_ex1_counters.dump "# of TCP-SSH packets: " $sshDestCountVar,
set UdpCountVar $(UdpCount.count), print >> click_ex1_counters.dump "# of UDP packets: " $UdpCountVar,
set UdpDnsCountVar $(UdpDnsCount.count), print >> click_ex1_counters.dump "# of UDP-DNS packets: " $UdpDnsCountVar
)



/*

#  of  ARP  packets:  12/0806						56
	#  of  ARP  request  packets:  12/0806 20/0001			54
	#  of  ARP  reply  packets:  12/0806 20/0002			2
#  of  IP  packets:  12/0800						1995
	#  of  ICMP  packets:  12/0800 23/01				8
	#  of  TCP  packets:  12/0800 23/06				1895
		#  of  TCP­-HTTP  packets:  12/0800 23/06 34 or 36 are 0050
		#  of  TCP-SSH  packets:  12/0800 23/06 34 or 36 are 0016
	#  of  UDP  packets:  12/0800 23/11				84
		#  of  UDP-DNS  packets: 12/0800 23/11 36/0035 46/0001		26

*/
