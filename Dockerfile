# Demonstrate a non-multi-stage build (Bloated Image)
# This Dockerfile includes all build tools and source code in the final image.

FROM node:22

WORKDIR /usr/local/app

# Copy the entire project
COPY . .

# ----------------------------
# Build the Frontend
# ----------------------------
WORKDIR /usr/local/app/client
# Install all dependencies (including devDependencies)
RUN npm install
# Build the static assets
RUN npm run build


# ----------------------------
# Setup the Backend
# ----------------------------
WORKDIR /usr/local/app/backend
# Install all dependencies (including devDependencies) because we aren't separating build/run stages
RUN npm install


# ----------------------------
# Combine Metadata
# ----------------------------
# Move the built frontend assets to the backend's static folder
# expected by the application logic
RUN mkdir -p src/static && cp -r /usr/local/app/client/dist/* src/static/

# Set environment
ENV NODE_ENV=production
EXPOSE 3000

# Run the application
CMD ["node", "src/index.js"]