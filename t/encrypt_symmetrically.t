#!/usr/bin/perl -w

use strict;
use English;

use lib './t';
use MyTest;
use MyTestSpecific;

TEST
{
    reset_handles();
    
    $gnupg->encrypt_symmetrically( handles => $handles );
    
    print $stdin @{ $texts{plain}->data() };
    close $stdin;
    wait;
    
    return $CHILD_ERROR == 0;
};



TEST
{
    reset_handles();
    
    $handles->stdin( $texts{plain}->fh() );
    $handles->options( 'stdin' )->{direct} = 1;
    $gnupg->encrypt_symmetrically( handles => $handles );
    
    wait;
    
    return $CHILD_ERROR == 0;
};