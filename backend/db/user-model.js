exports.User = {
    firstName : null,
    lastName : null,
    id : null,
    classIds : [],
    email : null,
    password : null,
    getUserJson : ()=>{
        return {
            "firstName" : this.firstName,
            "lastName" : this.lastName,
            "id" : this.id,
            "classIds" : this.classIds,
            "email" : this.email,
            "password" : this.password,
        }
    }
}

