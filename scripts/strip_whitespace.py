import re
import sys


with open(sys.argv[1]) as in_f:
	query = in_f.read().replace('\n', ' ').replace('\t', ' ')
	query = re.sub(' +', ' ', query)
	print(f"<query><![CDATA[{query}]]></query>")
