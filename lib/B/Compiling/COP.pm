package B::Compiling::COP;
use strict;
use warnings;

use base 'B::COP';

sub label {
    my $self = shift;
    B::Compiling::set_label(@_) if @_;
    $self->SUPER::label;
}

sub stash {
    my $self = shift;
    B::Compiling::set_stash(@_) if @_;
    $self->SUPER::stash;
}

sub stashpv {
    my $self = shift;
    B::Compiling::set_stashpv(@_) if @_;
    $self->SUPER::stashpv;
}

sub file {
    my $self = shift;
    B::Compiling::set_file(@_) if @_;
    $self->SUPER::file;
}

sub cop_seq {
    my $self = shift;
    B::Compiling::set_cop_seq(@_) if @_;
    $self->SUPER::cop_seq;
}

sub arybase {
    my $self = shift;
    B::Compiling::set_arybase(@_) if @_;
    $self->SUPER::arybase;
}

sub line {
    my $self = shift;
    B::Compiling::set_line(@_) if @_;
    $self->SUPER::line;
}

sub warnings {
    my $self = shift;
    B::Compiling::set_warnings(@_) if @_;
    $self->SUPER::warnings;
}

sub io {
    my $self = shift;
    B::Compiling::set_io(@_) if @_;
    $self->SUPER::io;
}

1;
