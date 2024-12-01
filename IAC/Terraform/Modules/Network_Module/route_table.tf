# Create a Route Table
resource "aws_route_table" "Public_Route_Table" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

# Associate the Route Table with the Subnet
resource "aws_route_table_association" "my_route_table_association" {
  subnet_id      = aws_subnet.Public_Subnet1.id
  route_table_id = aws_route_table.Public_Route_Table.id
}
resource "aws_route_table_association" "my_route_table_association2" {
  subnet_id      = aws_subnet.Public_Subnet2.id
  route_table_id = aws_route_table.Public_Route_Table.id
}