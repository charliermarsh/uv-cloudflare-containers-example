import { Container, getRandom } from "@cloudflare/containers";

const INSTANCE_COUNT = 3;

export class Backend extends Container {
  defaultPort = 8080;
  sleepAfter = "2h";
}

export default {
  async fetch(
    request: Request,
    env: { BACKEND: DurableObjectNamespace<Backend> },
  ): Promise<Response> {
    const containerInstance = await getRandom(env.BACKEND, INSTANCE_COUNT);
    return containerInstance.fetch(request);
  },
};
