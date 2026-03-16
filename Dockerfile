FROM node:alpine

COPY artiqui /artiqui
COPY book_priest /book_priest
COPY stitch /stitch

WORKDIR /artiqui
RUN npm install
RUN npm run build

WORKDIR /book_priest
RUN npm install

EXPOSE 5173

CMD ["npm","run","dev","--","--host"]