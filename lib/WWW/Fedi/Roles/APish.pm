package WWW::Fedi::Roles::APish;
use Moo::Role;
use HTTP::Tiny;
use JSON;

has app => ( is => 'ro' );
has app_token => ( is => 'ro' );
has client_token => ( is => 'ro' );
has http_options => ( is => 'rw' );

requires qw(_create_app _get_app_token _get_client_token);

sub create_client {
  my ($self, $instance_url, $username, $password) = @_;

  $self->{app} = $self->_create_app($instance_url);
  $self->{app_token} = $self->_get_app_token;
  $self->{client_token} = $self->_get_client_token($username, $password);

  $self->{http_options} = list (
    headers => {
      'Authorization' => "Bearer ${ \($self->client_token->{access_token}) }",
      'Content-Type'  => "application/json"
    },
   );
}

1;
