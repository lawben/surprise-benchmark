#!/bin/bash

set -e

cd "TPC-H V3.0.1/dbgen"
echo "Generating data..."
./dbgen -s 1
echo "Removing trailing separators..."
sed s'/.$//' -i *.tbl
echo "Moving data..."
cd ../../
mkdir -p data/tpch_data
mv "TPC-H V3.0.1/dbgen/supplier.tbl" data/tpch_data/supplier.tbl
mv "TPC-H V3.0.1/dbgen/customer.tbl" data/tpch_data/customer.tbl
mv "TPC-H V3.0.1/dbgen/orders.tbl" data/tpch_data/orders.tbl
mv "TPC-H V3.0.1/dbgen/lineitem.tbl" data/tpch_data/lineitem.tbl
mv "TPC-H V3.0.1/dbgen/part.tbl" data/tpch_data/part.tbl
mv "TPC-H V3.0.1/dbgen/partsupp.tbl" data/tpch_data/partsupp.tbl
mv "TPC-H V3.0.1/dbgen/nation.tbl" data/tpch_data/nation.tbl
mv "TPC-H V3.0.1/dbgen/region.tbl" data/tpch_data/region.tbl