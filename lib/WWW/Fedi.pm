package WWW::Fedi;
use Moo;
use strict;
use warnings FATAL => 'all';
use Type::Registry qw(t);
use namespace::clean;

t->add_types('-Standard');
t->add_types('-Common::String');

our $VERSION = "0.01";

has known_servers => (
  is => 'ro',
  isa => t('ArrayRef'),
);

has clients => (
  is => 'ro',
  isa => t('ArrayRef'),
);

has connected => (
  is => 'ro',
  isa => t('Bool')
);

sub connect {
  my $self = shift;

  $self->{connected} = 1;
}

1;
__END__

=encoding utf-8

=head1 NAME

WWW::Fedi - Connect to, and communicate with, fediverse instances which
speak ActivityPub/LitePub

=head1 SYNOPSIS

    use WWW::Fedi;

=head1 DESCRIPTION

WWW::Fedi is ...

=head1 LICENSE

Copyright (C) 7.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

7 E<lt>7@sevvie.ltdE<gt>

=cut

