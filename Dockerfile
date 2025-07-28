FROM cgr.dev/chainguard/go AS build

WORKDIR /oidc-discovery
COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -trimpath -ldflags="-s -w" -o oidc-discovery .

FROM cgr.dev/chainguard/glibc-dynamic

COPY --from=build /oidc-discovery/oidc-discovery /usr/local/bin/

ENTRYPOINT ["oidc-discovery"]
