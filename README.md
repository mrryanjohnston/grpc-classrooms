# GRPC Classrooms

Using two GRPC servers using ActiveRecord models from Rails Applications to
serve data to yet another Rails Application

## What is it?

This is an example of how you can use Rails as microservices to serve data to
other Rails services using GRPC.

`classrooms` is a Rails application. It describes `classroom` objects in terms
of their teachers. You can also see the names of students in `classrooms` by
looking at `classroom_student` objects.

`teachers` are served from models in the `teacher-profiles` rails application.

`students` are served from models in the `student-profiles` rails application.

This is not the most efficient way to do this; you'll notice there are many
calls to the database this way. Consider when you implement this that you'll
want to batch your requests somehow to the two microservices.

## Setup

You'll need ruby version `2.6.3`. Install the dependencies:

```bash
cd classrooms
bundle install
rails db:drop db:create db:migrate db:seed
cd ../student-profiles
bundle install
rails db:drop db:create db:migrate db:seed
cd ../teacher-profiles
bundle install
rails db:drop db:create db:migrate db:seed
```

## How To Run

You'll need to run the two GRPC Servers. In one terminal:

```
ruby ./student-profiles/lib/server.rb
```

and in another:


```
ruby ./teacher-profiles/lib/server.rb
```

finally, in a third:

```
cd ./classrooms
rails s
```

Now you can go to `localhost:3000/classrooms` and
`localhost:3000/classroom_students`.

If you want, you can also run the other two rails servers. In yet another
terminal:

```
cd ./teacher-profiles
rails s -p 9000
```

Now you can access `localhost:9000/teachers`.

and a fifth!:

```
cd ./student-profiles
rails s -p 9001
```

Now you can access `localhost:9001/students`.
