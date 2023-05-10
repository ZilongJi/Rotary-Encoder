# Rotary-Encoder
This is the matlab code to read data from the RLS rotary encoder.

I have already put the code (from https://www.rls.si/eng/e201-usb-encoder-interface-123) for E201-9Q Matlab interface into this repo. 

Before running, you may need to install the E201-9Q driver on your WINDOWS PC (check the link above). It says For Windows 10, use Microsoft inbox driver and not this package. However, it does not work on my PC and lap both of which use Windows10. So I download the driver to test on my PC. The Imaging PC at anatomy is running with Windows7, which definitely needs the driver. 

How to run:

1, run the matlab code xxx.m \
2, then you will pres a key 'g' (means go) on the key board to start logging the information from the Rotary-Encoder to a txt file in the Log file folder. \
3, after the imaging process finished, you will press a key 'b' (means break) on the key board to stop the logging. \

Easy and simple!

