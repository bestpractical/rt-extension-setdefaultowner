package RT::Action::SetDefaultOwner;

use strict;
use warnings;

use base qw(RT::Action);

sub Describe {
    my $self = shift;
    return ( ref $self );
}

sub Prepare {
    return (1);
}

sub Commit {
    my $self = shift;

    my $ticket = $self->TicketObj;
    if ( $ticket->Owner == $RT::Nobody->id ) {
        my $owner = RT->Config->Get('DefaultOwner');
        if ($owner) {
            my ( $ret, $msg ) = $ticket->SetOwner($owner);
            if ( $ret ) {
                return 1;
            }
            else {
                $RT::Logger->error( "Failed to set owner of ticket"
                      . $ticket->id
                      . " to $owner: $msg" );
            }
        }
        else {
            $RT::Logger->warn("No DefaultOwner set in config");
        }
    }
    return;
}

1;
