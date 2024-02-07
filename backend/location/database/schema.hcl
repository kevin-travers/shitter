schema "bathroomLocator"{
    comment = "database for Bathroom Location"
}

table "review"{
    comment = "Review table contains entry for each review of a bathroom"
    schema  = schema.bathroomLocator
    column "id" {
        null = false
        type = uuid
        default = sql("gen_random_uudi()")
        comment = "Unique identifer (GUID) for review"
    }
    column "user_id" {
        null    = false
        type    = uuid
        comment = "User id that owns created review"
    }
    column "bathroom_id"{
        null    = false
        type    = uuid
        comment = "Bathroom reference id that review associated"
    }
    column "rating" {
        null    = false
        type    = float
        comment = "Rating of the bathroom on a scale of 1-10"
    }
    column "description" {
        null    = true
        type    = varchar(255)
        comment = "Description of the bathroom"
    }
    column "tags" {
        null    = true
        type    = jsonb
        comment = "Tags are key value pairs that helo with filtering"
    }
    column "name" {
        null    = false
        type    = varchar(64)
        comment = "Name of the review"
    }
    column "helpful"{
        null    = true
        type    = int 
        default = 0
        comment = "How many found review to be helpfull"
    }
    column "not_helpful"{
        null    = true
        type    = int 
        default = 0
        comment = "How many found review to be unhelpful"
    }
    column "created" {
        null    = false
        type    = date
        default = sql("now()")
        comment = "Time when review was created"
    }
    column "updated" {
        null    = true
        type    = date
        comment = "Time review was last updated"
    }
    column "deleted" {
        null    = true
        type    = date
        comment = "Time the review was soft deleted"
    }
    primary_key{
        columns = [column.id]
    }
    foreign_key "review_bathroom_id"{
        columns         = [columns.bathroom_id]
        ref_columnds    = [table.bathroom.column.id]
        on_update       = RESTRICT
        on_delete       = RESTRICT
    }
}

table "bathroom"{
    comment = "Bathroom table stores entry for each bathroom location"
    schema  = schema.bathroomLocator
    column "id" {
        null = false
        type = uuid
        default = sql("gen_random_uudi()")
        comment = "Unique identifer (GUID) for bathroom"
    }
    column "name" {
        null    = false
        type    = varchar(64)
        comment = "Name of the bathroom"
    }
     column "description" {
        null    = true
        type    = varchar(255)
        comment = "Description of the bathroom"
    }
 
    column "location"{
        null    = false
        type    = GEOGRAPHY(POINT,4326)
        comment = "Location of the bathroom"
    }
    column "user_id" {
        null    = true
        type    = uuid
        comment = "User id that owns created bathroom location"
    }
    
    primary_key{
        columns = [column.id]
    }
}

table "image"{
    comment = ""
    schema  = schema.bathroomLocator
    column "id" {
        null = false
        type = uuid
        default = sql("gen_random_uudi()")
        comment = "Unique identifer (GUID) for image"
    }
    column "user_id" {
        null    = false
        type    = uuid
        comment = "User id that owns created review"
    }
    column "image_url"{
        null    = false
        type    = text
        comment = "s3 url location of bathroom image"
    }
    primary_key{
        columns = [column.id]
    }
    foreign_key "review_bathroom_id"{
        columns         = [columns.bathroom_id]
        ref_columnds    = [table.bathroom.column.id]
        on_update       = RESTRICT
        on_delete       = RESTRICT
    }
}
