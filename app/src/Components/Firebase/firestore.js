import { firestore } from './firebase';

export const createOpportunity = (data) =>
  firestore.collection('Opportunities').add(data)

export const onceGetOpportunities = () =>
  // db.ref('Opportunities').once('value');
  firestore.collection('Opportunities').get()

export const createIssuer = (institution, longName, url, phonenumber,street, housenumber,bus, postalcode, city, userId, userEmail) => {
    var addressdata = {
        bus: bus,
        city: city,
        housenumber: housenumber,
        postalcode: postalcode,
        street: street
    };
    var addressid;
    firestore.collection('Addresses').add(addressdata).
    then(function(docRef) {
        addressid = docRef.id;
        var issuerdata = {
            addressID: addressid,
            email: userEmail,
            institution: institution,
            name: longName,
            phonenumber: phonenumber,
            url: url
        };
        console.log(userId, issuerdata);
        firestore.collection('Issuers').doc(userId).set(issuerdata).catch(function(error) {

            console.error("Error adding document: ", error);

        });

    });

}
export const createAddress = (data) =>
  firestore.collection('Addresses').add(data);

export const onceGetBadges = () =>
  // db.ref('Opportunities').once('value');
  firestore.collection('Badges').get()


