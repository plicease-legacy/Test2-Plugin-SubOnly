use Test2::Bundle::Extended;
use Test2::Plugin::SubOnly qw( 2 );

is(
  intercept {
    subtest 'first' => sub { fail('oops') };
    subtest 'second' => sub { pass('good') };
  },
  array {
    event Subtest => sub {
      call pass           => T();
      call name           => 'first';
      call effective_pass => T();
      call subevents => array {
      
        event Plan => sub {
          call directive => 'SKIP';
        };
        end;
      
      };
    };
    event Subtest => sub {
      call pass           => T();
      call name           => 'second';
      call effective_pass => T();
      call subevents => array {
        event Ok => sub {
          call pass => T();
          call name => 'good';
        };
        event Plan => sub {};
        end;
      };
    };
    end;
    end;
  },
  'first subtest is skipped, second passes',
);

done_testing;
