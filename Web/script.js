async function uploadfile() {
    const fileInput = document.getElementById('fileInput');
    const status = document.getElementById('status');

    if (!fileInput.files.length) {
        status.textContent = "Please select a file to upload.";
        return;
    }
    
    const file = fileInput.files[0];


    const storageAccountName = "afloblobappstorage";
    const containerName = "afloresuploads";
    const sasToken  = "<your_sas_token>"; // Replace with your SAS token
    
    const blobUrl = `https://${storageAccountName}.blob.core.windows.net/${containerName}/${file.name}?${sasToken}`;

    try {
        const response = await fetch(blobUrl, {
            method: 'PUT',
            headers: {
                'x-ms-blob-type': 'BlockBlob',
            },
            body: file
        });

        if (response.ok) {
            status.textContent = `File uploaded successfully!: ${file.name}`;
        } else {
            const errorText = await response.text();
            status.textContent = `File upload failed: ${response.status} ${errText}`;
        }
    } catch (error) {
        status.textContent = `File upload failed: ${error.message}`;
    }
}