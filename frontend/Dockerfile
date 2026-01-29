FROM node:22-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm ci --omit=dev

COPY . .
ENV VITE_API_URL=http://k8s-ecommerc-mainlb-50fe372e3b-1026830903.ap-south-1.elb.amazonaws.com
RUN npm run build

FROM nginx:alpine
WORKDIR /app
COPY --from=builder /app/node_modules ./nodemodules

COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf


EXPOSE 80

CMD ["nginx","-g","daemon off;"]
