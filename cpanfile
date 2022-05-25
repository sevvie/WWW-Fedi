requires 'perl', '5.008001';

on 'test' => sub {
    requires 'Test::More', '0.98';
    requires 'Test::Mock::HTTP::Tiny', '0.002';
};

requires 'Module::Build::Tiny', '0.039';
requires "Moo", "2.005004";
requires "namespace::clean", "0.27";
requires "Type::Tiny", "1.012004";
requires "HTTP::Tiny", "0.080";
requires "JSON", "4.06";
