FROM node:22-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm ci --omit=dev

COPY . .
ENV VITE_API_URL=http://a6d35c9945ce542ad962db7d36ba636d-1979400558.ap-south-1.elb.amazonaws.com
RUN npm run build

FROM nginx:alpine

COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf


EXPOSE 80

CMD ["nginx","-g","daemon off;"]
