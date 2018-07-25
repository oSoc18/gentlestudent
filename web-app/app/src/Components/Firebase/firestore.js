import { firestore } from './firebase';

export const createOpportunity = (data) =>
  firestore.collection('Opportunities').add(data)

export const onceGetOpportunities = () =>
  // db.ref('Opportunities').once('value');
  firestore.collection('Opportunities').get()

export async function createIssuer(institution, longName, url, phonenumber,street, housenumber,bus, postalcode, city, userId, userEmail) {
    var addressdata = {
        bus: bus,
        city: city,
        housenumber: parseInt(housenumber),
        postalcode: parseInt(postalcode),
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
            url: url,
            validated: false
        };
        console.log(userId, issuerdata);
        firestore.collection('Issuers').doc(userId).set(issuerdata).catch(function(error) {

            console.error("Error adding document: ", error);

        });

    });

}
export const createAddress = (data) =>
  firestore.collection('Addresses').add(data)

export const onceGetBadges = () =>
  // db.ref('Opportunities').once('value');
  firestore.collection('Badges').get()

export const onceGetNonValidatedIssuers = () =>
  firestore.collection('Issuers').where('validated', '==', false).get()

export const validateIssuer = (id) =>
  firestore.collection('Issuers').doc(id).update({ validated: true })

export const onceGetNonValidatedOpportunities = () =>
  firestore.collection('Opportunities').where('blocked', '==', true).get()

export const onceGetValidatedOpportunities = () =>
  firestore.collection('Opportunities').where('blocked', '==', false).get()

export const validateOpportunity = (id) =>
  firestore.collection('Opportunities').doc(id).update({ blocked: false })

export const createNewBadge = (data) =>
  firestore.collection('Badges').add(data)

export const linkBadgeToOpportunity = (opportunityId, badgeId) =>
  firestore.collection('Opportunities').doc(opportunityId).update({ badgeId: badgeId })

export const onceGetCreatedOpportunities = (userId) =>
  firestore.collection('Opportunities').where('issuerId', '==', userId).get()

export const onceGetParticipationsForOpportunity = (opportunityId) =>
  firestore.collection('Participations').where('opportunityId', '==', opportunityId).get()

export const onceGetParticipant = (id) =>
  firestore.collection('Participants').doc(id).get()

export const createNewAssertion = (data) =>
  firestore.collection('Assertions').add(data)

export const createNewParticipant = (id, data) =>
  firestore.collection('Participants').doc(id).set(data);

export const linkBeaconToOpportunity = (opportunityId, beaconId) =>
  firestore.collection('Opportunities').doc(opportunityId).update({ beaconId: beaconId })

export const onceGetIssuer = (id) =>
  firestore.collection('Issuers').doc(id).get()

export const onceGetAdmin = (id) =>
  firestore.collection('Admins').doc(id).get()

export const undoParticipation = (id) =>
  firestore.collection('Participations').doc(id).update({status: 0})

export const acceptParticipation = (id) =>
  firestore.collection('Participations').doc(id).update({status: 1})

export const rejectParticipation = (id) =>
  firestore.collection('Participations').doc(id).update({status: 2})