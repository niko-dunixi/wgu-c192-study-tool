# WGU C192 Study Tool

## What is it?
Often the hardest part of studing for a particular technology isn't
the technology itself but is getting it to the point to start using
it. I find that dockerizing a given setup is the fastest way for me
to get up and running. Not only can I get the database up and running
quickly, but I can reset the data back to its original state. I'll be 
less delicate and more likely to experiment if I can get a system back
to factory settings as fast as possible.

## Prerequisites
  1. Unix like terminal. Can be any of:
     * Windows: [WSL](https://docs.microsoft.com/en-us/windows/wsl/install-win10)
     * Linux/MacOS: Bash
  1. Docker
     * Windows: [Docker Machine](https://docs.docker.com/toolbox/toolbox_install_windows/) and [Virtual Box](https://www.virtualbox.org/)
     * MacOS: [Docker for Desktop](https://hub.docker.com/editions/community/docker-ce-desktop-mac)
     * Linux: [Installation appropriate for your distro](https://docs.docker.com/engine/install/ubuntu/)

## How do I use it?

Open your terminal in the way that's available to your system and
navigate to this repository and then execute the following commands

```bash
$ cd wgu-c192-study-tool
$ ./start.sh
$ ./psql.sh
> c192=#
```

You can now enter whatever SQL commands you wish!

```sql
> c192=# select * from branch;
```
<pre>
 branchno |    street    |   city   | postcode
----------+--------------+----------+----------
 B005     | 22 Deer Rd   | London   | SW1 4EH
 B007     | 16 Argyll St | Aberdeen | AB2 3SU
 B003     | 163 Main St  | Glasgow  | G11 9QX
 B004     | 32 Manse Rd  | Bristol  | BS99 1NZ
 B002     | 56 Clover Dr | London   | NW10 6EU
(5 rows)
</pre>

## Contents

### DreamHome Example

The book frequently references a DreamHome case study. Setting this
database up is tedious and isn't provided by the class, but fortunately
for you it's now automatic. The tables are all set up as I've interpreted
their relationships in the uCertify content to explain. If anything is
not correct, PRs are appreciated and will help others down the line.

<pre>
                       Table "public.branch"
  Column  |         Type          | Collation | Nullable | Default
----------+-----------------------+-----------+----------+---------
 branchno | character(5)          |           | not null |
 street   | character varying(35) |           |          |
 city     | character varying(10) |           |          |
 postcode | character varying(10) |           |          |
Indexes:
    "branch_pkey" PRIMARY KEY, btree (branchno)
Referenced by:
    TABLE "propertyforrent" CONSTRAINT "propertyforrent_branchno_fkey" FOREIGN KEY (branchno) REFERENCES branch(branchno) ON DELETE SET NULL
    TABLE "registration" CONSTRAINT "registration_branchno_fkey" FOREIGN KEY (branchno) REFERENCES branch(branchno) ON DELETE CASCADE
    TABLE "staff" CONSTRAINT "staff_branchno_fkey" FOREIGN KEY (branchno) REFERENCES branch(branchno) ON DELETE SET NULL
</pre>

<pre>
                       Table "public.staff"
  Column  |         Type          | Collation | Nullable | Default
----------+-----------------------+-----------+----------+---------
 staffno  | character(5)          |           | not null |
 fname    | character varying(10) |           |          |
 lname    | character varying(10) |           |          |
 position | character varying(10) |           |          |
 sex      | character(1)          |           |          |
 dob      | date                  |           |          |
 salary   | integer               |           |          |
 branchno | character(5)          |           |          |
Indexes:
    "staff_pkey" PRIMARY KEY, btree (staffno)
Foreign-key constraints:
    "staff_branchno_fkey" FOREIGN KEY (branchno) REFERENCES branch(branchno) ON DELETE SET NULL
Referenced by:
    TABLE "propertyforrent" CONSTRAINT "propertyforrent_staffno_fkey" FOREIGN KEY (staffno) REFERENCES staff(staffno) ON DELETE SET NULL
    TABLE "registration" CONSTRAINT "registration_staffno_fkey" FOREIGN KEY (staffno) REFERENCES staff(staffno) ON DELETE CASCADE
</pre>

<pre>
                    Table "public.privateowner"
  Column  |         Type          | Collation | Nullable | Default
----------+-----------------------+-----------+----------+---------
 ownerno  | character(5)          |           | not null |
 fname    | character varying(10) |           |          |
 lname    | character varying(10) |           |          |
 address  | character varying(50) |           |          |
 telno    | character(15)         |           |          |
 email    | character varying(50) |           |          |
 password | character varying(40) |           |          |
Indexes:
    "privateowner_pkey" PRIMARY KEY, btree (ownerno)
Referenced by:
    TABLE "propertyforrent" CONSTRAINT "propertyforrent_ownerno_fkey" FOREIGN KEY (ownerno) REFERENCES privateowner(ownerno) ON DELETE CASCADE
</pre>

<pre>
                   Table "public.propertyforrent"
   Column   |         Type          | Collation | Nullable | Default
------------+-----------------------+-----------+----------+---------
 propertyno | character(5)          |           | not null |
 street     | character varying(35) |           |          |
 city       | character varying(10) |           |          |
 postcode   | character varying(10) |           |          |
 type       | character varying(10) |           |          |
 rooms      | smallint              |           |          |
 rent       | integer               |           |          |
 ownerno    | character(5)          |           | not null |
 staffno    | character(5)          |           |          |
 branchno   | character(5)          |           |          |
Indexes:
    "propertyforrent_pkey" PRIMARY KEY, btree (propertyno)
Foreign-key constraints:
    "propertyforrent_branchno_fkey" FOREIGN KEY (branchno) REFERENCES branch(branchno) ON DELETE SET NULL
    "propertyforrent_ownerno_fkey" FOREIGN KEY (ownerno) REFERENCES privateowner(ownerno) ON DELETE CASCADE
    "propertyforrent_staffno_fkey" FOREIGN KEY (staffno) REFERENCES staff(staffno) ON DELETE SET NULL
Referenced by:
    TABLE "viewing" CONSTRAINT "viewing_propertyno_fkey" FOREIGN KEY (propertyno) REFERENCES propertyforrent(propertyno) ON DELETE CASCADE
</pre>

<pre>
                       Table "public.client"
  Column  |         Type          | Collation | Nullable | Default
----------+-----------------------+-----------+----------+---------
 clientno | character(5)          |           | not null |
 fname    | character varying(10) |           |          |
 lname    | character varying(10) |           |          |
 telno    | character(15)         |           |          |
 preftype | character varying(10) |           |          |
 maxrent  | integer               |           |          |
 email    | character varying(50) |           |          |
Indexes:
    "client_pkey" PRIMARY KEY, btree (clientno)
Referenced by:
    TABLE "registration" CONSTRAINT "registration_clientno_fkey" FOREIGN KEY (clientno) REFERENCES client(clientno) ON DELETE CASCADE
    TABLE "viewing" CONSTRAINT "viewing_clientno_fkey" FOREIGN KEY (clientno) REFERENCES client(clientno) ON DELETE CASCADE
</pre>

<pre>
                       Table "public.viewing"
   Column   |         Type          | Collation | Nullable | Default
------------+-----------------------+-----------+----------+---------
 clientno   | character(5)          |           | not null |
 propertyno | character(5)          |           | not null |
 viewdate   | date                  |           |          |
 comment    | character varying(15) |           |          |
Indexes:
    "viewing_pkey" PRIMARY KEY, btree (clientno, propertyno)
Foreign-key constraints:
    "viewing_clientno_fkey" FOREIGN KEY (clientno) REFERENCES client(clientno) ON DELETE CASCADE
    "viewing_propertyno_fkey" FOREIGN KEY (propertyno) REFERENCES propertyforrent(propertyno) ON DELETE CASCADE
</pre>

<pre>
                Table "public.registration"
   Column   |     Type     | Collation | Nullable | Default
------------+--------------+-----------+----------+---------
 clientno   | character(5) |           | not null |
 branchno   | character(5) |           | not null |
 staffno    | character(5) |           | not null |
 datejoined | date         |           |          |
Foreign-key constraints:
    "registration_branchno_fkey" FOREIGN KEY (branchno) REFERENCES branch(branchno) ON DELETE CASCADE
    "registration_clientno_fkey" FOREIGN KEY (clientno) REFERENCES client(clientno) ON DELETE CASCADE
    "registration_staffno_fkey" FOREIGN KEY (staffno) REFERENCES staff(staffno) ON DELETE CASCADE
</pre>
