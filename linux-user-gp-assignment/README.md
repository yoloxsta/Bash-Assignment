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

=>Important: -aG means append group (never forget -a).
```
### Check group members:
```
getent group devops
```
### Step 4: Login as Users & Verify Groups
Switch user:
```
su - user1
```
### Check groups:
```
groups

- Expected:

user1 devops
```
### Step 5: Create a Shared Directory
Create a directory for the group:
```
sudo mkdir /shared-devops

Change group ownership:

sudo chown :devops /shared-devops

Check:

ls -ld /shared-devops

Output example:

drwxr-xr-x root devops /shared-devops
```
### Step 6: Set Group Permissions
Allow group read/write/execute:
```
sudo chmod 770 /shared-devops

Explanation:

7 = rwx (owner)
7 = rwx (group)
0 = --- (others)

Verify:

ls -ld /shared-devops
```
### Step 7: Enable Group File Sharing (IMPORTANT)
So new files inherit the group:
```
sudo chmod g+s /shared-devops

Check:

ls -ld /shared-devops

You should see:

drwxrws--- root devops /shared-devops

s = setgid
```
### Step 8: Test Access (user1 & user2)
Login as user1:
```
su - user1
cd /shared-devops
touch user1.txt
echo "Hello from user1" > user1.txt
ls -l

Exit and login as user2:

su - user2
cd /shared-devops
cat user1.txt
touch user2.txt

Works because both are in devops.
```
### Step 9: Test Denied Access (user3)
Login as user3:
```
su - user3
cd /shared-devops

Expected:
Permission denied
```
