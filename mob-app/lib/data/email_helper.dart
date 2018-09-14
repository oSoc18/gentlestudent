import 'package:Gentle_Student/data/secrets.dart';
import 'package:Gentle_Student/models/opportunity.dart';
import 'package:Gentle_Student/models/user.dart';
import 'package:mailer2/mailer.dart';

class EmailHelper {
  EmailHelper(Issuer issuer, Participant participant, Opportunity opportunity) {
    _sendEmail(issuer, participant, opportunity);
  }

  _sendEmail(Issuer issuer, Participant participant, Opportunity opportunity) {
    // ENKEL VOOR TE TESTEN:
    // var options = new GmailSmtpOptions()
    // ..username = "lekkerlokaalst@gmail.com"
    // ..password = "LokaalLekker123";

    Secrets secrets = new Secrets();

    var options = new SmtpOptions()
      ..username = secrets.getEmail()
      ..password = secrets.getWachtwoord()
      ..hostName = "smtp.office365.com"
      ..name = "Office365"
      ..port = 587;
      //..ignoreBadCertificate = false
      //..requiresAuthentication = true
      //..secured = true;

    // Create our email transport.
    var emailTransport = new SmtpTransport(options);

    // Create our mail/envelope.
    var envelope = new Envelope()
      ..from = 'gentlestudent@arteveldehs.be'
      //..recipients.add(issuer.email)
      ..recipients.add("dries.vanacker@arteveldehs.be")
      ..subject = 'Inschrijving voor leerkans: ' + opportunity.title
      ..html = '<p>Dag partner van Gentlestudent,</p>' +
          '<p>Er heeft zich zopas iemand ingeschreven voor de leerkans ${opportunity.title}.</p>' +
          '<p>De gegevens van deze persoon zijn: </p>' +
          '<p> - Naam: ${participant.name}</p>' +
          '<p> - E-mail: ${participant.email}</p>' +
          '<p>Er zijn nu in totaal ${opportunity.participations + 1} personen ingeschreven voor deze leerkans.</p>' +
          '<p>Met vriendelijke groet,</p>' +
          '<p>Team Gentlestudent</p>';

    // Email it.
    emailTransport
        .send(envelope)
        .then((envelope) => print('Email sent!'))
        .catchError((e) => print('Error occurred: $e'));
  }
}
