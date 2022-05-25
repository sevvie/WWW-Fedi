use strict;
use JSON;
use Test::More tests => 3;
use Test::Mock::HTTP::Tiny;

use_ok $_ for qw(WWW::Fedi);

my $client = new_ok 'WWW::Fedi' => [
    instance_type => "Mastodon",
    instance_url => "https://mastodon.url",
    username => "username",
    password => "password"
];

my $oauth_oob = "urn:ietf:wg:oauth:2.0:oob";
my $app_client_id = "TWhM-tNSuncnqN7DBJmoyeLnk6K3iJJ71KKXxgL1hPM";
my $app_client_secret = "ZEaFUFmF0umgBX1qKJDjaU99Q31lDkOU8NutzTOoliw";
my $app_client_vapid_key = "BCk-QqERU0q-CfYZjcuB6lnyyOYfJ2AifKqfeGIm7Z-HiTU5T9eTG5GxVA0_OH5mMlI4UkkDTpaZwozy0TzdZ2M=";
my $app_client_access_token = "ZA-Yj3aBD8U8Cm7lKUp-lm9O9BmDgdhHzDeqsY8tlL0";
my $user_access_token = "ZA-Yj3aBD8U8Cm7lKUp-lm9O9BmDgdhHzDeqsY8tlL1";

my $mock_data = [
  {
    url => 'https://mastodon.url/api/v1/apps',
    method => 'POST',
    args => {},
    response => {
      content => to_json({
	id => "123456",
	name => "test app",
	website => undef,
	redirect_uri => $oauth_oob,
	client_id => $app_client_id,
	client_secret => $app_client_secret,
	vapid_key => $app_client_vapid_key,
      })
    }
  },
  {
    url => 'https://mastodon.url/oauth/token',
    method => 'POST',
    args => {
      headers => {
	'Content-Type' => 'application/x-www-form-urlencoded',
      },
      content => {
	client_id => $app_client_id,
	client_secret => $app_client_secret,
	redirect_uri => $oauth_oob,
	grant_type => "client_credentials",
      },
    },
    response => {
      content => to_json({
	access_token => $app_client_access_token,
	"token_type" => "Bearer",
	"scope" => "read write follow push",
	"created_at" => 1573979017,
      }),
    },
  },
  {
    url => 'https://mastodon.url/oauth/token',
    method => 'POST',
    args => {
      headers => {
	'Authorization' => "Bearer $app_client_access_token",
	'Content-Type' => 'application/json',
      },
      content => {
	client_id => $app_client_id,
	client_secret => $app_client_secret,
	redirect_uri => $oauth_oob,
	grant_type => 'password',
	username => 'user',
	password => 'password',
	scope => 'read write follow push'
      },
    },
    response => {
      content => to_json({
	access_token => $user_access_token,
	"token_type" => "Bearer",
	"scope" => "read write follow push",
	"created_at" => 1573979017,
      }),
    },
  },
];

Test::Mock::HTTP::Tiny->set_mocked_data($mock_data);

$client->connect;
is $client->connected, 1, "client can connect";
