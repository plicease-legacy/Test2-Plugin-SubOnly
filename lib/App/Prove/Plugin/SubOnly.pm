package App::Prove::Plugin::SubOnly;

use strict;
use warnings;
use 5.008001;

# ABSTRACT: Prove plugin for skipping subtests
# VERSION

=head1 SYNOPSIS

 # test only the second and third subtest
 % prove -PSubOnly=2,3 t/foo.t

=head1 DESCRIPTION

This is just a L<prove> friendly interface for L<Test2::Plugin::SubOnly>.

=head1 SEE ALSO

=over 4

=item L<Test2::Plugin::SubOnly>

=back

=cut

sub load
{
  my ($class, $p) = @_;
  my $values = join ',', @{ $p->{args} };
  $ENV{PERL5OPT} = "-MTest2::Plugin::SubOnly=$values";
}

1;
