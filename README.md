Structure of DataBase

自動でぷ


## User
### associationはあああ

```
has_many :prototypes, likes, comments
```

### table
- name
- email
- password
- avatar
- profile
- position
- occupation

## Prototype
### association

```
has_many :captured_images, comments, likes
has_many :tag_prototypes
has_many :tags , through :tag_prototype
belongs_to :user
```

### table
- title
- catch_copy
- concept
- user_id

## CapturedImage
### association

```
belongs_to :prototype
```

### table
- content
- status
- prototype_id


## Like
### association

```
belongs_to :user, :prototype
```

### table
- user_id
- prototype_id



## Comment
### association

```
belongs_to :user, :prototype
```

### table
- content
- user_id
- prototype_id

## Tag
### association

```
has_many :tag_prototypes
has_many :prototypes, through :tag_prototype
```

## table
- id
- name

## Tag_Prototype
### association

```
belongs_to :tag,:prototype
```

## table
- prototype_id
- tag_id


