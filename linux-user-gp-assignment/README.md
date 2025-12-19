# Linux Lab: Users, Groups & File Permissions (Ubuntu)

## Lab Objectives
You will learn:

- Create 3 users
- Create a group
- Add users to a group
- Understand file & directory permissions
- Test access using real commands

### Step 1: Create 3 Users
```
sudo useradd -m user1
sudo useradd -m user2
sudo useradd -m user3
```
### Set passwords:
```
sudo passwd user1
sudo passwd user2
sudo passwd user3
```
### Verify:
```
cat /etc/passwd | grep user
```
### Step 2: Create a Group
Create a group called devops:
```
sudo groupadd devops
```
### Verify:
```
getent group devops
```
### Step 3: Add Users to Group
Add user1 and user2 to devops group:
```
sudo usermod -aG devops user1
sudo usermod -aG devops user2

⚠️ Important: -aG means append group (never forget -a).
```
### 