#  UserId.pm
#    - providing an object-oriented approach to GnuPG user ids
#
#  Copyright (C) 2000 Frank J. Tobin <ftobin@cpan.org>
#
#  This module is free software; you can redistribute it and/or modify it
#  under the same terms as Perl itself.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#
#  $Id: UserId.pm,v 1.7 2001/08/21 13:31:50 ftobin Exp $
#

package GnuPG::UserId;
use Any::Moose;

has [qw( validity as_string )] => (
    isa => 'Any',
    is  => 'rw',
);

has signatures => (
    isa       => 'ArrayRef',
    is        => 'rw',
    default   => sub { [] },
);

sub push_signatures {
    my $self = shift;
    push @{ $self->signatures }, @_;
}

# DEPRECATED
sub user_id_string {
    my ( $self, $v ) = @_;
    $self->as_string($v) if defined $v;
    return $self->as_string();
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

GnuPG::UserId - GnuPG User ID Objects

=head1 SYNOPSIS

  # assumes a GnuPG::PublicKey object in $publickey
  my $user_id = $publickey->user_ids_ref->[0]->as_string;

=head1 DESCRIPTION

GnuPG::UserId objects are generally not instantiated on their
own, but rather as part of GnuPG::PublicKey or GnuPG::SecretKey
objects.

=head1 OBJECT METHODS

=over 4

=item new( I<%initialization_args> )

This methods creates a new object.  The optional arguments are
initialization of data members;

=back

=head1 OBJECT DATA MEMBERS

=over 4

=item as_string

A string of the user id.

=item validity

A scalar holding the value GnuPG reports for the trust of authenticity
(a.k.a.) validity of a key.
See GnuPG's DETAILS file for details.

=item signatures

A list of GnuPG::Signature objects embodying the signatures
on this user id.

=back

=head1 SEE ALSO

L<GnuPG::Signature>,

=cut
