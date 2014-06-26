
#  
#  Copyright 2014 INRA-CIRAD
#  
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 3 of the License, or
#  (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, see <http://www.gnu.org/licenses/> or 
#  write to the Free Software Foundation, Inc., 
#  51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#  
#  

=head1 NAME

Softwares.pm - All software paths constants

=head1 DESCRIPTION

This module contains all softwares (used in arcad project) path must be stored here.
For example, GATK, cutadapt, bwa,...
When a path is not available, value -1 is returned otherwise path of software is given.

=head1 SYNOPSIS / USAGE

use strict;
use Carp;
use Modules::Config::Softwares;

my $gatkPath = &$Softwares::GATK_DIRECTORY or confess($!);

=cut

package Softwares;

use strict;
use warnings;

=head1 CONSTANTS

C<$PICARD_TOOLS_DIRECTORY> Path where to find all Picard tools (*.jar), Version 1.7

C<$GATK_DIRECTORY> Path where to find all GATK jar files, Version 1.6

C<$JAVA_PATH> Lastest version of java command, Version 1.6

C<$SAMTOOLS_PATH> Lastest version of samtools, Version 0.1.18

C<$BWA_PATH> Lastest version of bwa, Version 0.5.9

=cut

our $PICARD_TOOLS_DIRECTORY = sub {
	return '/home/sarah1/src/picard-tool' if( -d '/home/sarah1/src/picard-tool' );
	return;
};

our $GATK_DIRECTORY         = sub {
	return '/usr/local/bioinfo/GATK' if( -d '/usr/local/bioinfo/GATK' );
	return;
};

our $JAVA_PATH              = sub {
	return '/usr/local/jre/bin/java' if( -e '/usr/local/jre/bin/java' );
	return;
};

our $SAMTOOLS_PATH          = sub {
	return '/usr/bin/samtools' if( -e '/usr/bin/samtools' );
	return;
};

our $BWA_PATH               = sub {
	return '/usr/local/bioinfo/bwa/bwa' if( -e '/usr/local/bioinfo/bwa/bwa' );
	return;
};

our $CUTADAPT_PATH              = sub {
	return '/usr/bin/cutadapt' if( -e '/usr/bin/cutadapt' );
	return;
};

our $ABYSS_PE_PATH              = sub {
	return '/usr/local/bioinfo/abyss/bin/abyss-pe' if( -e '/usr/local/bioinfo/abyss/bin/abyss-pe' );
	#return '/usr/local/bioinfo/abyss-1.3.2/bin/abyss-pe' if( -e '/usr/local/bioinfo/abyss-1.3.2/bin/abyss-pe' );
	return;
};

our $CAP3_PATH              = sub {
	return '/usr/local/bioinfo/CAP3/cap3' if( -e '/usr/local/bioinfo/CAP3/cap3' );
	return;
};

our $FASTQC_PATH              = sub {
	return "/usr/local/bioinfo/FastQC/fastqc -j " . &$JAVA_PATH if( -e '/usr/local/bioinfo/FastQC/fastqc' );
	return;
};

our $ARCAD_SCRIPT_PATH              = sub {
	my $script_name = shift;
	$script_name =~ s/^\s||\s$//;
	return if( !defined $script_name || $script_name eq "" );
	if( -d '/NAS/arcad_data/Softs/tags/' && -e "/NAS/arcad_data/Softs/tags/$script_name")
	{
		return "/NAS/arcad_data/Softs/tags/$script_name";
	}
	elsif ( -e $script_name )
	{
		return $script_name;
	}
	return;
};

our $RH_QSUB = sub {
	
	return {
		q    => 'arcad.q',
		b    => 'y',
		sync => 'y',
		cwd  => '',
		N    => 'arcad_job',
	};
};

sub make_qsub_command
{
	my $rh_qsub = shift;
	my $commandLine = shift;
	
	my $com = 'qsub ';
	$com .= "-$_ $$rh_qsub{$_} " for( keys %$rh_qsub );
	$com .= $commandLine if( $commandLine );
	return $com;
}

1;

=head1 INCOMPATIBILITIES

Fully compatble with all version of perl

=head1 BUGS AND LIMITATIONS

NO BUG FOUND YET

=head1 AUTHORS

=over 1

=item Homa Felix

=item felix.homa-at-cirad.fr

=back

=head1 VERSION

1.0.0

=head1 DATE

26/06/2012

=head1 LICENSE AND COPYRIGHT

  Copyright 2014 INRA-CIRAD
  
  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 3 of the License, or
  (at your option) any later version.
  
  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.
  
  You should have received a copy of the GNU General Public License
  along with this program; if not, if not, see <http://www.gnu.org/licenses/> 
  or write to the Free Software Foundation, Inc.,
  51 Franklin Street, Fifth Floor, Boston,
  MA 02110-1301, USA.

=cut
