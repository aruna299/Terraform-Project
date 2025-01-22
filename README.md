# Terraform-Project

## Virtual Private Cloud (VPC) (A private, isolated network in AWS)
A **Virtual Private Cloud (VPC)** is a logically isolated network in AWS where you can launch and manage resources like EC2 instances, databases, and more. It provides full control over your network configuration, including IP address ranges, subnets, route tables, and gateways.

### Key Features:
- Customizable IP address ranges with CIDR blocks (e.g., 10.0.0.0/16).
- Ability to create subnets for organizing resources across Availability Zones.
- Integration with other AWS services for scalable and secure networking.

## Subnets (Segments of a VPC for organizing resources)
A **subnet** is a range of IP addresses within a VPC that divides the VPC into smaller segments. Subnets are typically used to group resources by function, security requirements, or availability.

### Types of Subnets:
1. **Public Subnets**: Accessible from the internet; resources need an associated internet gateway.
2. **Private Subnets**: Isolated from the internet; used for backend resources like databases.

### Key Points:
- Subnets reside in a single Availability Zone.
- Each subnet is associated with a CIDR block, which is a subset of the VPC's CIDR range.

## Internet Gateway (IGW) (Enables internet access for public subnets)
An **Internet Gateway (IGW)** is a horizontally scaled, redundant, and highly available component that allows communication between resources in a VPC and the internet.

### Functions:
- Enables inbound and outbound internet traffic for public subnets.
- Must be attached to a VPC and referenced in route tables for internet access.

## Route Tables (Direct network traffic within and outside the VPC)
A **route table** contains rules (routes) that determine where network traffic is directed. Each subnet must be associated with a route table, which defines the next-hop destination for traffic leaving the subnet.

### Key Components:
- **Routes**: Specify destinations (e.g., 0.0.0.0/0) and targets (e.g., IGW).
- **Main Route Table**: Default route table for a VPC; additional custom route tables can be created.

### Example:
- Public subnet route: “0.0.0.0/0” pointing to an Internet Gateway.
- Private subnet route: Routes pointing to a NAT Gateway for outbound internet traffic.

## Security Groups (Instance-level firewalls)
**Security Groups** act as virtual firewalls for your AWS resources, controlling inbound and outbound traffic at the instance level.

### Key Features:
- Stateless: Allow or deny traffic based on defined rules.
- Rules specify protocols, ports, and IP ranges (e.g., SSH access on port 22 from 0.0.0.0/0).
- Rules are applied to individual resources, such as EC2 instances.

### Example:
- Inbound Rule: Allow HTTP traffic (port 80) from 0.0.0.0/0.
- Outbound Rule: Allow all traffic to 0.0.0.0/0.

## Network Access Control Lists (NACLs) (Subnet-level stateless traffic control)
**NACLs** are optional layers of security for controlling traffic at the subnet level. Unlike security groups, NACLs are stateless, meaning both inbound and outbound rules must be explicitly defined.

### Key Features:
- Stateless: Rules are evaluated in both directions.
- Rules are processed in order based on rule number.
- Default NACL allows all inbound and outbound traffic; custom NACLs start with no rules.

### Use Cases:
- Block specific IP addresses or ports at the subnet level.
- Add an additional layer of security.

## Elastic IP (EIP) (Static public IP addresses for consistent external access)
An **Elastic IP (EIP)** is a static, public IPv4 address designed for dynamic cloud computing. It allows resources like EC2 instances to have a consistent public IP, even after restarts.

### Key Points:
- EIPs are allocated to your AWS account.
- They can be associated with and disassociated from resources dynamically.
- Only one EIP is free per account; additional usage incurs charges.

### Example:
- Assign an EIP to an EC2 instance in a public subnet for consistent external access.



