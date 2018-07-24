import { storage } from './firebase';

// Create a root reference
var storageRef = storage.ref();

//expects File file and String path
export const uploadImage = (file, path) =>
    {
        // Create a reference to 'images/mountains.jpg'
        let ref = storageRef.child(path);
        ref.put(file).then(function(snapshot) {
            console.log('Uploaded file!');
          });
    }
    