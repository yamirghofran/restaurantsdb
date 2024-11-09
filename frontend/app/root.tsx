import {
  Links,
  Meta,
  Outlet,
  Scripts,
  ScrollRestoration,
  useRouteError,
  isRouteErrorResponse,
} from "@remix-run/react";
import type { LinksFunction, LoaderFunction } from "@remix-run/node";

import "./tailwind.css";
import { SidebarProvider, SidebarTrigger } from "./components/ui/sidebar";

export const links: LinksFunction = () => [
  { rel: "preconnect", href: "https://fonts.googleapis.com" },
  {
    rel: "preconnect",
    href: "https://fonts.gstatic.com",
    crossOrigin: "anonymous",
  },
  {
    rel: "stylesheet",
    href: "https://fonts.googleapis.com/css2?family=Inter:ital,opsz,wght@0,14..32,100..900;1,14..32,100..900&display=swap",
  },
];

export function Layout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en">
      <head>
        <meta charSet="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <Meta />
        <Links />
      </head>
      <body>
        {children}
        <ScrollRestoration />
        <Scripts />
      </body>
    </html>
  );
}

export default function App() {
  return <Outlet />;
}

export function ErrorBoundary() {
  const error = useRouteError();

  return (
    <html lang="en" className="h-full">
      <head>
        <Meta />
        <Links />
      </head>
      <body className="h-full">
        <div className="min-h-full flex flex-col items-center justify-center p-4">
          <div className="space-y-4 text-center">
            <h1 className="text-2xl font-bold">
              {isRouteErrorResponse(error)
                ? `${error.status} ${error.statusText}`
                : 'Application Error'}
            </h1>
            <p className="text-gray-600">
              {isRouteErrorResponse(error)
                ? error.data
                : 'Sorry, something went wrong. Please try again later.'}
            </p>
          </div>
        </div>
        <Scripts />
      </body>
    </html>
  );
}
