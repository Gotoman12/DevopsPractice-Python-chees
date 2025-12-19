pipeline{
    agent any
    parameters{
        choice(name:'terrafromAction',choices:['apply','destroy'],description:'choose the terraform Action')
    }

    environment{
        AWS_ACCESS_KEY_ID = credentials()
        AWS_SECRET_KEY_ID = credentials()
    }
}