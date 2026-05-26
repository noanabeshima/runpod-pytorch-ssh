# RunPod PyTorch SSH

RunPod-compatible PyTorch image with OpenSSH listening on port 22.

Image:

```text
ghcr.io/noanabeshima/runpod-pytorch-ssh:latest
```

Set `SSH_PUBLIC_KEY` or `PUBLIC_KEY` to append public keys to `/root/.ssh/authorized_keys` at container startup.
