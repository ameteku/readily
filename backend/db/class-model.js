

exports. Class = {
    title : null,
    id : null,
    permissions : {
        admin : null,
        allowedReaders: [],
        allowedWriters : [],
        allowedDeleters : [],
    }
}

exports.Topic = {
    topicName : null,
    resourceList : [],
}

exports.Note = {
    isPrivate: false,
    noteLink : null,
    uploaderId : null,
    noteId : null,
    setNote : (isPrivate, noteLink, uploaderId, noteId)=>{
        this.isPrivate = isPrivate;
        this.noteId = noteId;
        this.uploaderId = uploaderId;
        this.noteLink = noteLink;
    },
    getjson : function () {
       return {
           "isPrivate" : this.isPrivate,
           "noteLink" : this.noteLink,
           "uploaderId" : this.uploaderId,
           "noteId" : this.noteId
       }
    }
}