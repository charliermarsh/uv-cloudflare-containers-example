# uv-cloudflare-containers-example

[![Deploy to Cloudflare](https://deploy.workers.cloudflare.com/button)](https://deploy.workers.cloudflare.com/?url=https://github.com/charliermarsh/uv-cloudflare-containers-example)

Deploying a FastAPI application to [Cloudflare Containers](https://developers.cloudflare.com/containers/) with [uv](https://docs.astral.sh/uv/).

## Usage

From the `./app` subdirectory, run the FastAPI server locally with:

```bash
uv run fastapi dev
```

From the repository root, build the container artifact locally:

```bash
npm install
docker build .
```

then deploy to Cloudflare with:

```bash
npx wrangler deploy
```

A successful deploy will display the URL of your deployed https app. You may need to wait a few minutes for it to be available.

Check your **Cloudflare Account Home** -> **Compute (Workers)** -> **Containers** web dashboard for more information. 

Useful commands to follow up:

```bash
npx wrangler deployments status
npx wrangler containers --help
```

Consult Cloudflare official docs for advanced usage,

## Troubleshooting

- 💸 During the containers beta, you must be on at least the [$5 Workers Paid Plan](https://dash.cloudflare.com/?to=/:account/workers/plans/purchase) to deploy containers, otherwise you will encounter `Unauthorized Errors` during `wrangler deploy` step.
- If you paid for the plan and still see `Unauthorized Errors`, do `npx wrangler logout` then `npx wrangler login` to refresh your permission scopes
