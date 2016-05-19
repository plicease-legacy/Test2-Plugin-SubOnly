package Test2::Plugin::SubOnly;

use strict;
use warnings;
use 5.008001;
use Test2::API qw( context );
use Test2::Tools::Basic qw( skip_all );
use Monkey::Patch qw( patch_package );
use Test2::Tools::Subtest ();

# ABSTRACT: Skip all but select subtests
# VERSION

=head1 SYNOPSIS

 # test only the second and third subtest
 % perl -MTest2::Plugin::SubOnly=2 t/foo.t

=head1 DESCRIPTION

This plugin skips all but specific subtests in a test.
This is helpful if you have a long running test file
where all the subtests are independent, and you are
working on a specific subtest.

This probably violates the spirit, or the rule of the
L<Test2::API>.  As such it may not work with all tools,
and it may break when changes happen in the L<Test2>
internals.

=head1 SEE ALSO

=over 4

=item L<Test2>

=item L<Test2::API>

=item L<Test2::Tools::Subtest>

=item L<App::Prove::Plugin::SubOnly>

=back

=cut

our $depth = 0;
our @patches;

sub import {

  my $class = shift;
  
  my %numbers = map { $_ => 1 } split /,/, join ',', @_;

  my $code = sub {
    my $original = shift;
    my $name     = shift;
    my $code     = shift;
    
    $depth++;
    
    my $ctx = context();
    my $hub = $ctx->hub;
    my $test_number = $hub->count + 1;
    #$ctx->note('number = ' . $test_number);
    #$ctx->note('depth  = ' . $depth);
    $ctx->release;

    unless($numbers{$test_number} || $depth > 1)
    {
      $code = sub { skip_all('skipping') };
    }

    my $pass = $original->($name, $code, @_);    
    $depth--;
    return $pass;
  };
  
  # may need to add to this list
  push @patches, patch_package $_, run_subtest => $code for qw( Test2::Tools::Subtest Test2::API );
};

1;
