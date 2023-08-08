---
layout: post
title: Configuring a Canon camera as a webcam in Ubuntu
category: post
comments: True
---

In recent weeks, I found myself facing a common challenge: transforming my Canon M50 into a functional webcam on Ubuntu. While Canon offers a straightforward solution, the [EOS Webcam Utility](https://www.usa.canon.com/cameras/eos-webcam-utility) for Windows users, Ubuntu lacks native support. Fear not, for alternatives do exist. In this guide, I'll delve into the process of utilizing your Canon camera as a webcam using the micro-USB cable method.

 <!--more-->

### Hardware needed

First, you will need any Canon camera, plus a micro-USB cable. The battery of your camera may drain very fast, so it's also nice to have a dummy battery. I'm using [this model](https://pt.aliexpress.com/item/4001053523952.html?spm=a2g0o.productlist.main.7.30df44211Tn0NR&algo_pvid=eac33e3c-80e3-44c8-bfae-ee96168f051e&algo_exp_id=eac33e3c-80e3-44c8-bfae-ee96168f051e-3&pdp_npi=4%40dis%21BRL%2152.47%2149.33%21%21%2110.20%21%21%402101f49f16915234827514532e83e3%2110000013819565073%21sea%21BR%21192545786%21&curPageLogUid=ZsUYHxJNx8y9) from Aliexpress, but there are other options, like some ones plugged directly into the power socket.

### Camera configurations

Begin by disabling the Eco mode on your Canon M50. This precaution prevents the camera from automatically powering off during use. On Canon M50, go to the wrench option, then you will find the Eco mode option on the second page. Switch it to Off.

![Eco mode Canon M50](/public/images/canonm5-ecomode.jpeg)

### Installng dependencies

These are the needed packages:

{% highlight bash %}
sudo apt-get install gphoto2 v4l2loopback-utils v4l2loopback-dkms ffmpeg build-essential libelf-dev linux-headers-$(uname -r) unzip vlc
{% endhighlight %}

### Create a script file

I find it more useful and less error-prone to have the commands needed to start the camera on a script file. So, create a file called `start-canon.sh` with the following content:

{% highlight bash %}
sudo rmmod v4l2loopback # remove the module if it's already loaded
sudo modprobe v4l2loopback exclusive_caps=1 max_buffers=2 card_label="Canon M50" # load the module with the needed parameters
sudo pkill -9 gphoto # kill any gphoto process that may be running
gphoto2 --stdout --capture-movie | ffmpeg -i - -vcodec rawvideo -af "hqdn3d" -pix_fmt yuv420p -threads 0 -s:v 1920x1080 -f v4l2 /dev/video2 # start the camera
{% endhighlight %}

You may need to change the resolution of the video, under the `-s:v` parameter. You can also change the device name, if you want, in card_label parameter.

Since I'm using a laptop, the camera is mounted in `/dev/video2`. If you are using a desktop, it may be mounted in `/dev/video0` or `/dev/video1`. You can check the device name with the command `v4l2-ctl --list-devices`.

Then, plug the camera on the USB port, change the camera to video mode, and run the script:

{% highlight bash %}
chmod +x start-canon.sh
./start-canon.sh
{% endhighlight %}

### Using the camera as a webcam

Now, you can use the camera as a webcam. You can use it in Zoom, Google Meet, or any other software that uses the webcam. You can also use it in VLC, by opening the device as listed on the `gphoto2` command.

## References

- [Canon M50 as a webcam on Linux](https://www.reddit.com/r/linuxquestions/comments/j0vb1x/using_canon_eos_m50_as_a_webcam/)
- [Using a Canon DSLR as a webcam with Debian/Ubuntu](https://maximevaillancourt.com/blog/canon-dslr-webcam-debian-ubuntu)
