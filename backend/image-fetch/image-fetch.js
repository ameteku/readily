const { BlobServiceClient } = require('@azure/storage-blob');
const { v1: uuidv1} = require('uuid');
const { AZURE_STORAGE_CONNECTION_STRING } = require('./connection-string');

async function uploadBlob(data) {
    const blobServiceClient = BlobServiceClient.fromConnectionString(AZURE_STORAGE_CONNECTION_STRING);
    const containerName = 'images';
    const containerClient = blobServiceClient.getContainerClient(containerName);
    const blobName = 'image' + uuidv1() + '.jpg';
    const blockBlobClient = containerClient.getBlockBlobClient(blobName);
    const uploadBlobResponse = await blockBlobClient.upload(data, data.length);
    console.log("Blob was uploaded successfully. requestId: ", uploadBlobResponse.requestId);
}

