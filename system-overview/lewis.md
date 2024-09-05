# Lewis

Currently has a U250 installed with a custom application deployed which requires an older linux kernel.

Lewis is configured with kernel 5.15.0.

Hold set with:
```bash
apt-mark hold 5.15.0-72-generic
```

To remove hold:
```bash
apt-mark unhold 5.15.0-72-generic
```
