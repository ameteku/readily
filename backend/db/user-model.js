var User = {
    firstName : null,
    lastName : null,
    id : null,
    classIds : [],
    getUserJson : ()=>{
        return {
            "firstName" : this.firstName,
            "lastName" : this.lastName,
            "id" : this.id,
            "classIds" : this.classIds,
        }
    }
}

