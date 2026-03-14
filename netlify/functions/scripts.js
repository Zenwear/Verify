import { getStore } from '@netlify/blobs';

export default async (req, context) => {
  const url = new URL(req.url);
  const pathParts = url.pathname.split('/').filter(p => p);
  const store = getStore('scripts');

  if (pathParts[0] === 'raw' && pathParts[1]) {
    const id = pathParts[1];
    const blob = await store.get(id, { type: 'blob' });
    if (!blob) {
      return new Response('Not Found', { status: 404 });
    }

    return new Response(blob, {
      headers: { 'Content-Type': 'text/plain' }
    });
  }

  if (pathParts[0] === 'api' && pathParts[1] === 'scripts') {
    if (req.method === 'GET' && pathParts.length === 2) {
      const list = [];
      for await (const entry of store.list()) {
        const metadata = await store.get(entry.key, { type: 'metadata' });
        list.push({ id: entry.key, name: metadata?.name || entry.key });
      }
      return Response.json(list);
    }

    if (req.method === 'POST' && pathParts.length === 2) {
      const { name, content } = await req.json();
      const id = name.replace(/[^a-z0-9]/gi, '_') + '_' + Date.now();
      await store.set(id, content, { metadata: { name } });
      return Response.json({ id, name });
    }

    if (req.method === 'GET' && pathParts.length === 3) {
      const id = pathParts[2];
      const content = await store.get(id);
      const metadata = await store.get(id, { type: 'metadata' });
      if (content === null) {
        return new Response('Not Found', { status: 404 });
      }
      return Response.json({ id, name: metadata?.name || id, content });
    }

    if (req.method === 'PUT' && pathParts.length === 3) {
      const id = pathParts[2];
      const { name, content } = await req.json();
      await store.set(id, content, { metadata: { name } });
      return Response.json({ id, name });
    }

    if (req.method === 'DELETE' && pathParts.length === 3) {
      const id = pathParts[2];
      await store.delete(id);
      return new Response(null, { status: 204 });
    }
  }

  return new Response('Not Found', { status: 404 });
};

export const config = {
  path: ['/api/*', '/raw/*']
};
