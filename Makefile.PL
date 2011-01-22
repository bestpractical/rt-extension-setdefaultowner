use inc::Module::Install;
RTx('RT-Extension-SetDefaultOwner');
all_from('lib/RT/Extension/SetDefaultOwner.pm');
&WriteAll;
